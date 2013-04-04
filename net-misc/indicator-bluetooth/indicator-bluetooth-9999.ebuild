# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16
VALA_USE_DEPEND=vapigen

inherit gnome2-utils vala autotools-utils bzr

DESCRIPTION="The bluetooth menu"
HOMEPAGE="https://launchpad.net/indicator-bluetooth"
EBZR_REPO_URI="lp:indicator-bluetooth"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="nls static-libs"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libdbusmenu:3[gtk]
	dev-libs/libindicator:3
	>=net-wireless/gnome-bluetooth-3
	x11-libs/gtk+:3
	x11-libs/libido"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	AUTOTOOLS_AUTORECONF=yes
}

src_prepare() {
	autotools-utils_src_prepare
	vala_src_prepare
}

src_configure() {
 	local myeconfargs=(
 		$(use_enable nls)
 	)

 	autotools-utils_src_configure
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

