# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.20

inherit gnome2-utils vala cmake-utils versionator

DESCRIPTION="Modular desktop settings hub"
HOMEPAGE="http://launchpad.net/switchboard"
SRC_URI="http://launchpad.net/${PN}/$(get_version_component_range 1-1).x/${PV}/+download/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0.8
	media-video/cheese
	x11-libs/gtk+:3
	>=x11-libs/granite-0.3
	!pantheon-base/libpantheon"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

DOCS=( AUTHORS COPYING )

src_prepare() {
	epatch_user

	# Disable generation of the translations (if needed)
	use nls || sed -i '/add_subdirectory(po)/d' CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_UNITY=OFF
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
