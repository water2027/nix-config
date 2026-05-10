{ pkgs, ... }:

{
	programs.wlogout.style = let
		iconPath = "${pkgs.wlogout}/share/wlogout/icons";
	in ''
* {
	background-image: none;
	box-shadow: none;
}

window {
	background-color: rgba(12, 12, 12, 0.9);
}

button {
  border-radius: 0;
  border-color: black;
	text-decoration-color: #FFFFFF;
  color: #FFFFFF;
	background-color: #1E1E1E;
	border-style: solid;
	border-width: 1px;
	background-repeat: no-repeat;
	background-position: center;
	background-size: 25%;
}

button:active, button:hover {
	background-color: #3700B3;
	outline-style: none;
}

button:focus {
    outline-style: none;
}

#lock {
    background-image: image(url("${iconPath}/lock.png"));
}

#logout {
    background-image: image(url("${iconPath}/logout.png"));
}

#suspend {
    background-image: image(url("${iconPath}/suspend.png"));
}

#hibernate {
    background-image: image(url("${iconPath}/hibernate.png"));
}

#shutdown {
    background-image: image(url("${iconPath}/shutdown.png"));
}

#reboot {
    background-image: image(url("${iconPath}/reboot.png"));
}
	'';
}