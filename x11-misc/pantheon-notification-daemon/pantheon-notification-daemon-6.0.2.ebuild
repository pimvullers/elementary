# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala

DESCRIPTION="Gtk notification server for Pantheon"
HOMEPAGE="https://github.com/elementary/notifications"
SRC_URI="https://github.com/elementary/notifications/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite:0
	gui-libs/libhandy:1
	media-libs/libcanberra[gtk3]
	x11-libs/gtk+:3
"

S="${WORKDIR}/notifications-${PV}"

src_prepare() {
	eapply_user
	vala_src_prepare
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
