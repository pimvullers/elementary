# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="The Elementary OS (meta package)"
HOMEPAGE="http://www.elementaryos.org/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	=app-dicts/purple-11.03.2
	|| ( app-office/libreoffice ( app-office/abiword app-office/gnumeric ) )
	=app-office/dexter-0.18
	=mail-client/postler-0.1.1
	=www-client/midori-0.4.0
	x11-themes/elementary-icon-theme
	x11-themes/elementary-theme"
