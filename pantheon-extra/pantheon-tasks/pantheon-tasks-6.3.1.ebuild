# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Elementary OS tasks and reminders"
HOMEPAGE="https://github.com/elementary/tasks"
SRC_URI="https://github.com/elementary/tasks/archive/${PV}.tar.gz -> ${P}.tar.gz"

inherit gnome2-utils meson vala xdg-utils

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	$(vala_depend)
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	dev-libs/libical
	<gnome-extra/evolution-data-server-3.46
	media-libs/clutter:1.0
	media-libs/clutter-gtk:1.0
	media-libs/libchamplain:0.12[gtk]
	sci-geosciences/geocode-glib
	app-misc/geoclue:2.0
	gui-libs/libhandy:1
	dev-libs/libgdata
	>=dev-libs/glib-2.39:2
	dev-libs/granite:0
	x11-libs/gtk+:3
"

S="${WORKDIR}/tasks-${PV}"

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
