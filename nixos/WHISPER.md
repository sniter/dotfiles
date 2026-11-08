# whisper.cpp on NixOS

Local speech-to-text using [whisper.cpp](https://github.com/ggerganov/whisper.cpp) (nixpkgs package: `whisper-cpp`, currently v1.8.7). Main binary is `whisper-cli`.

## Try it without installing

```shell
nix run nixpkgs#whisper-cpp -- --help
```

## Install

### Ad-hoc shell

```shell
nix shell nixpkgs#whisper-cpp
```

### Persistent (home-manager)

Add to a packages file, e.g. `home/ilya/packages/media.nix`:

```nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    whisper-cpp
    # ...
  ];
}
```

Then `sudo nixos-rebuild switch --flake ~/dotfiles/nixos`.

### Persistent (system-wide)

Add `whisper-cpp` to `environment.systemPackages` in the host's `system.nix` instead, if you want it available for all users.

## Download a model

The package ships a helper script:

```shell
whisper-cpp-download-ggml-model base.en ~/.local/share/whisper-models
```

Common model sizes: `tiny.en`, `base.en`, `small.en`, `medium.en`, `large-v3`. English-only (`.en`) models are faster/smaller if you don't need multilingual support.

## Prepare audio with ffmpeg

whisper.cpp's native format is 16 kHz, mono, 16-bit PCM WAV — that's what the model was trained on. The nixpkgs build links ffmpeg and will accept other formats/rates directly, but resampling yourself is more predictable and noticeably faster (no per-run decode) for anything batch or non-trivial:

```shell
ffmpeg -i input.mp3 -ar 16000 -ac 1 -c:a pcm_s16le audio.wav
```

- `-ar 16000` — resample to 16 kHz
- `-ac 1` — downmix to mono
- `-c:a pcm_s16le` — 16-bit signed PCM (uncompressed)

Same command works for `.m4a` (e.g. iPhone voice memos, AAC-in-MP4) — ffmpeg reads the container/codec automatically from the input file, no extra flags needed:

```shell
ffmpeg -i input.m4a -ar 16000 -ac 1 -c:a pcm_s16le audio.wav
```

Extract audio straight out of a video file the same way:

```shell
ffmpeg -i input.mp4 -vn -ar 16000 -ac 1 -c:a pcm_s16le audio.wav
```

Normalize loudness first if the source is quiet or unevenly leveled (helps accuracy on mumbly/far-mic recordings):

```shell
ffmpeg -i input.mp3 -af loudnorm -ar 16000 -ac 1 -c:a pcm_s16le audio.wav
```

Trim to a time range before transcribing a long recording:

```shell
ffmpeg -i input.wav -ss 00:05:00 -to 00:10:00 -ar 16000 -ac 1 -c:a pcm_s16le clip.wav
```

## Transcribe a file

```shell
whisper-cli -m ~/.local/share/whisper-models/ggml-base.en.bin -f audio.wav
```

Useful flags:

```shell
whisper-cli -m ggml-base.en.bin -f audio.wav -otxt        # write audio.wav.txt
whisper-cli -m ggml-base.en.bin -f audio.wav -osrt         # write .srt subtitles
whisper-cli -m ggml-base.en.bin -f audio.wav -l auto        # auto-detect language
whisper-cli -m ggml-base.en.bin -f audio.wav -t 8           # use 8 threads
```

Input isn't limited to WAV — the package is built with ffmpeg support, so mp3/mp4/etc. work directly:

```shell
whisper-cli -m ggml-base.en.bin -f podcast.mp3 -otxt
```

## Live mic transcription

The package includes `whisper-stream` (built with SDL2 by default):

```shell
whisper-stream -m ggml-base.en.bin -t 8 --step 0 --length 30000
```

## Local HTTP server

```shell
whisper-server -m ggml-base.en.bin --port 8080
```

Then POST audio to `http://localhost:8080/inference` (OpenAI-compatible-ish REST API — see upstream docs).

## GPU acceleration

By default the nixpkgs build is CPU-only. To build with CUDA, override the package and enable unfree + cuda config (`hosts/nixos/system.nix` already sets `nixpkgs.config.allowUnfree = true`):

```nix
{
  nixpkgs.config.cudaSupport = true;

  home.packages = [
    (pkgs.whisper-cpp.override { cudaSupport = true; })
  ];
}
```

This requires an Nvidia GPU with the proprietary driver installed and will trigger a local build (long compile, no CUDA cache on regular Hydra). ROCm (`rocmSupport = true`) works the same way for AMD GPUs.

## Notes

- `mainProgram` is `whisper-cli`; other binaries from the same derivation: `whisper-server`, `whisper-stream`, `whisper-bench`, `whisper-command`, `whisper-quantize`, `whisper-talk-llama`.
- Models aren't bundled — always fetch them separately via `whisper-cpp-download-ggml-model` or manually from [Hugging Face (ggerganov/whisper.cpp)](https://huggingface.co/ggerganov/whisper.cpp/tree/main).