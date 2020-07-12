# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.40

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="LightDM Greeter for Pantheon"
HOMEPAGE="https://github.com/elementary/greeter"
SRC_URI="https://github.com/elementary/greeter/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE="nls"

RDEPEND="
	gnome-base/gnome-settings-daemon
	sys-apps/accountsservice
	x11-libs/gdk-pixbuf:2
	dev-libs/granite
	x11-libs/gtk+:3
	>=x11-misc/lightdm-1.2.1[vala]
	x11-wm/mutter
	pantheon-base/wingpanel
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	$(vala_depend)
	>=dev-util/meson-0.50.0
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

S="${WORKDIR}/greeter-${PV}"

src_prepare() {
	eapply_user
	vala_src_prepare
}

src_configure() {
	meson_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}
