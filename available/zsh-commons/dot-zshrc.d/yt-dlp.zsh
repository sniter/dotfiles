(( $+commands[yt-dlp] )) || return 1
function ytmp3(){
  set -x;
  yt-dlp \
    --progress\
    --write-thumbnail \
    -x --audio-format mp3\
    --audio-quality 0 \
    --embed-thumbnail \
    --embed-metadata \
    -v --convert-thumbnail jpg --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" --exec ffprobe \
    "$@";
  set +x;
}
