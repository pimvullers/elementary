# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

VALA_MIN_API_VERSION=0.22

inherit vala cmake-utils

DESCRIPTION="Switchboard plug to show system information."
HOMEPAGE="http://launchpad.net/switchboard-plug-about"
SRC_URI="http://launchpad.net/switchboard-plug-a11y/loki/${PV}/+download/switchboard-plug-a11y-${PV}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE="nls"

RDEPEND="
	x11-libs/granite
	x11-libs/gtk+:3
	>=pantheon-base/switchboard-2"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/switchboard-plug-a11y-${PV}"

src_prepare() {
	use nls || sed -i '/add_subdirectory (po)/d' CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="${VALAC}"
	)
	cmake-utils_src_configure
}
