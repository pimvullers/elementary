# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16
VALA_MAX_API_VERSION=0.16

inherit vala cmake-utils bzr

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
	$(vala_depend)
	virtual/pkgconfig"

src_prepare() {
	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="${VALAC}"
	)

	cmake-utils_src_configure
}

