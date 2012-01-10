# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="The Pantheon desktop from Elementary OS (meta package)"
HOMEPAGE="http://www.elementaryos.org/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	|| ( app-dicts/lingo app-dicts/purple )
	app-editors/scratch
	|| ( 
		app-office/libreoffice 
		app-office/libreoffice-bin
		( app-office/abiword app-office/gnumeric ) 
	)
	app-office/dexter
	app-office/maya
	dev-util/euclide
	pantheon-base/marlin
	pantheon-base/pantheon-shell
	pantheon-base/switchboard
	mail-client/postler
	media-sound/beatbox
	www-client/midori
	x11-misc/lightdm
	x11-terms/pantheon-terminal
	x11-themes/elementary-icon-theme
	x11-themes/elementary-theme"
