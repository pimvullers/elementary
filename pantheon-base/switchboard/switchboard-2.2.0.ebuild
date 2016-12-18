# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

VALA_MIN_API_VERSION=0.22

inherit gnome2-utils vala cmake-utils

DESCRIPTION="Modular desktop settings hub"
HOMEPAGE="http://launchpad.net/switchboard"
SRC_URI="http://launchpad.net/${PN}/2.x/${PV}/+download/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE="nls"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0.8
	media-libs/clutter-gtk
	x11-libs/gtk+:3
	>=x11-libs/granite-0.3"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	eapply_user

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
