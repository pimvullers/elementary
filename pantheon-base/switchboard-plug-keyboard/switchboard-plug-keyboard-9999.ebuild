# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.20

inherit vala cmake-utils bzr

DESCRIPTION="This plug can be used to change several keyboard settings"
HOMEPAGE="https://launchpad.net/switchboard-plug-default-applications"
EBZR_REPO_URI="lp:switchboard-plug-keyboard"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="nls"

CDEPEND="
	dev-libs/glib
	x11-libs/granite"
RDEPEND="${CDEPEND}
	gnome-base/libgnomekbd
	>=pantheon-base/switchboard-2"
DEPEND="${CDEPEND}
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
