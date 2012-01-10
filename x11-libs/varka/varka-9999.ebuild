# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils bzr

DESCRIPTION="A library on top of gtk to build applications"
HOMEPAGE="http://launchpad.net/varka"
EBZR_REPO_URI="lp:varka"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-lang/vala:0.14"

pkg_setup() {
	DOCS="AUTHORS COPYING NEWS README"
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="$(type -p valac-0.14)"
	)

	cmake-utils_src_configure
}

