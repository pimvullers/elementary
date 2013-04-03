# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16

inherit vala cmake-utils bzr

DESCRIPTION="Power plug for switchboard"
HOMEPAGE="https://code.launchpad.net/~elementary-apps/pantheon-plugs/power-plug"
EBZR_REPO_URI="lp:~elementary-apps/pantheon-plugs/power-plug"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	pantheon-base/libpantheon
	pantheon-base/switchboard
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

src_prepare() {
	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="${VALAC}"
	)

	cmake-utils_src_configure
}

