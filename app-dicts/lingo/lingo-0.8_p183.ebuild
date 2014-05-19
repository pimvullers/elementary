# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.20

inherit versionator gnome2-utils vala cmake-utils bzr

MY_PV=$(get_version_component_range 3)

DESCRIPTION="The sexiest dictionary on Earth and Jupiter"
HOMEPAGE="https://launchpad.net/lingo-dictionary"
EBZR_REPO_URI="lp:lingo-dictionary"
EBZR_REVISION=${MY_PV:1}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug nls"

RDEPEND="
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libgee:0.8
	net-libs/libsoup:2.4
	x11-libs/gtk+:3
	x11-libs/granite"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

DOCS=( AUTHORS COPYING )

src_prepare() {
	epatch_user

	use nls || sed -i 's/add_subdirectory(po)//' CMakeLists.txt
	sed -i 's/gee-1.0/gee-0.8/' CMakeLists.txt

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

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
