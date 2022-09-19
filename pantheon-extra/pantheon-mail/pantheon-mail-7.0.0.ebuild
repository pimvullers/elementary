# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Elementary OS mail reader"
HOMEPAGE="https://github.com/elementary/mail"
SRC_URI="https://github.com/elementary/mail/archive/${PV}.tar.gz -> ${P}.tar.gz"

inherit gnome2-utils meson vala xdg-utils

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:0
	dev-libs/folks
	dev-libs/libgee:0.8
	gui-libs/libhandy:1
	net-libs/webkit-gtk:4
	gnome-extra/evolution-data-server[vala]
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	$(vala_depend)"

S="${WORKDIR}/mail-${PV}"

src_prepare() {
	eapply_user
	vala_setup
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_icon_cache_update
	gnome2_schemas_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	gnome2_schemas_update
	xdg_desktop_database_update
}
