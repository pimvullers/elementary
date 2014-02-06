# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="The Pantheon desktop from Elementary OS (meta package)"
HOMEPAGE="http://www.elementaryos.org/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	app-dicts/lingo
	app-editors/scratch
	app-office/dexter
	app-office/maya
	dev-libs/contractor
	mail-client/geary
	media-sound/noise
	media-video/audience
	pantheon-base/pantheon-files
	pantheon-base/pantheon-shell
	pantheon-base/switchboard
	www-client/midori
	x11-terms/pantheon-terminal
	x11-themes/elementary-icon-theme
	x11-themes/elementary-theme"
