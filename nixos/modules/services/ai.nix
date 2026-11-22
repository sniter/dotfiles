{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    chatgpt
    claude-code
  ];

}


