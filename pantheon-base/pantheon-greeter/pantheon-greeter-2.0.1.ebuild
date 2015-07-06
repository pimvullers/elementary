# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.26

inherit gnome2-utils vala cmake-utils versionator

DESCRIPTION="Pantheon Login Screen for LightDM"
HOMEPAGE="http://launchpad.net/pantheon-greeter"
SRC_URI="http://launchpad.net/${PN}/freya/${PV}/+download/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="nls"

RDEPEND="
	dev-libs/libindicator:3
	media-fonts/raleway
	media-libs/clutter-gtk:1.0
	virtual/opengl
	x11-libs/granite
	x11-libs/gtk+:3
	>=x11-misc/lightdm-1.2.1"
DEPEND="${DEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	# Disable generation of the translations (if needed)
	use nls || sed -i '/add_subdirectory (po)/d' CMakeLists.txt

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
