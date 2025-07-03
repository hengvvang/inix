{
   programs.zsh = {
   	enable = true;
   	enableCompletion = true;
   	autosuggestion.enable = true;
   	syntaxHighlighting.enable = true;
   	oh-my-zsh = {
   		enable = true;
   		plugins = [ "docker-compose" "docker" ];
   		theme = "dst";
   	};
   	initContent = ''
   		bindkey '^f' autosuggest-accept
   	'';
   };
   
   programs.fzf = {
   	enable = true;
   	enableZshIntegration = true;
   };
}
