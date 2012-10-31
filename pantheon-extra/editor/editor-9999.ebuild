# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils bzr

DESCRIPTION="A new editor by Tom Beckman"
HOMEPAGE="https://code.launchpad.net/~tombeckmann/+junk/editor"
EBZR_REPO_URI="lp:~tombeckmann/+junk/editor"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	x11-libs/granite
	x11-libs/gtksourceview"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="$(type -p valac-0.16)"
	)

	cmake-utils_src_configure
}

