# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.24
VALA_USE_DEPEND=vapigen

inherit gnome2-utils autotools vala xdg-utils

DESCRIPTION="The dock for elementary Pantheon, stupidly simple"
HOMEPAGE="https://launchpad.net/plank https://launchpad.net/pantheon-dock"
SRC_URI="https://launchpad.net/plank/1.0/${PV}/+download/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+dbus debug nls static-libs"

CDEPEND="
	dev-libs/glib:2
	dbus? ( dev-libs/libdbusmenu[gtk3] )
	dev-libs/libgee:0.8
	>=gnome-base/gnome-menus-3.32.0
	>=x11-libs/bamf-0.2.92
	>=x11-libs/cairo-1.10
	>=x11-libs/gdk-pixbuf-2.26.0
	>=x11-libs/gtk+-3.10.0:3
	x11-libs/libX11
	x11-libs/libwnck:3
"
RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}
	$(vala_depend)
	dev-util/intltool
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
"

DOCS=( AUTHORS COPYING COPYRIGHT NEWS README )

src_prepare() {
	eautoreconf

	vala_src_prepare
	default
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable nls) \
		$(use_enable dbus dbusmenu)
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_gconf_install
	gnome2_schemas_update
	xdg_icon_cache_update
}

pkg_postrm() {
	gnome2_gconf_uninstall
	gnome2_schemas_update
	xdg_icon_cache_update
}

