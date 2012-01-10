# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils bzr

DESCRIPTION="A library for interacting with various Pantheon Desktop Environment components"
HOMEPAGE="https://launchpad.net/libpantheon"
EBZR_REPO_URI="lp:libpantheon"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-lang/vala:0.14
	dev-libs/glib:2
	x11-libs/gtk+:3"

DOCS="AUTHORS COPYING COPYRIGHT NEWS README"

src_prepare() {
	sed -i "s/NAMES valac/NAMES valac-0.14/" cmake/vala/FindVala.cmake
}

