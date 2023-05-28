fx_version 'cerulean'
game 'gta5'
lua54 'yes'

Name 'krs-billing'
Author 'Karos#7804'
version "1.0.0"
Discord 'https://discord.gg/wM4XDaXfU8' -- 𝗞𝗥𝗦® --


client_script {
    'client/**.lua'
}

server_script {
    'server/**.lua'
}

ui_page 'ui/krs.html'

files{
    'ui/krs.html',
    'ui/krs.css',
    'ui/krs.js',
}

dependencies {
	'es_extended',
}