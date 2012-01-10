# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils bzr

DESCRIPTION="Modular desktop settings hub"
HOMEPAGE="https://launchpad.net/switchboard"
EBZR_REPO_URI="lp:switchboard"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	x11-libs/granite
	dev-libs/libgee"
DEPEND="${RDEPEND}
	dev-lang/vala:0.14"

pkg_setup() {
	DOCS=( AUTHORS COPYING )
}

src_prepare() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE=$(type -p valac-0.14)
	)

	cmake-utils_src_configure
}

