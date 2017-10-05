# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

VALA_MIN_API_VERSION=0.22
VALA_MAX_API_VERSION=0.34

inherit vala cmake-utils

DESCRIPTION="Adjust keyboard settings from Switchboard"
HOMEPAGE="https://launchpad.net/switchboard-plug-keyboard"
SRC_URI="https://launchpad.net/${PN}/loki/${PV}/+download/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND="
	dev-libs/glib
	gnome-base/libgnomekbd
	x11-libs/granite
	x11-libs/gtk+:3
	>=pantheon-base/switchboard-2"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

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
