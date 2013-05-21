# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16

inherit vala cmake-utils bzr

DESCRIPTION="Configure various aspects of the Pantheon desktop environment using Switchboard."
HOMEPAGE="https://launchpad.net/switchboard-plug-pantheon-shell"
EBZR_REPO_URI="lp:switchboard-plug-pantheon-shell"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

CDEPEND="
	pantheon-base/libpantheon
	x11-libs/granite"
RDEPEND="${CDEPEND}
	pantheon-base/switchboard"
DEPEND="${CDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

src_prepare() {
	use nls || sed -i 's/add_subdirectory (po)//' CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="${VALAC}"
	)

	cmake-utils_src_configure
}

