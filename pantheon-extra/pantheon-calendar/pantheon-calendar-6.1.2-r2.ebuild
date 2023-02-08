# Copyright 2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.40

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Desktop calendar app designed for elementary OS"
HOMEPAGE="https://github.com/elementary/calendar"
SRC_URI="https://github.com/elementary/calendar/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	app-misc/geoclue:2.0
	dev-libs/folks
	dev-libs/glib:2
	dev-libs/granite:0
	dev-libs/libgee:0.8
	dev-libs/libical
	>=gnome-extra/evolution-data-server-3.8
	>=gui-libs/libhandy-0.90.0:1
	media-libs/clutter:1.0
	media-libs/clutter-gtk:1.0
	media-libs/libchamplain:0.12[gtk,vala]
	net-libs/libsoup:2.4
	sci-geosciences/geocode-glib:0
	>=x11-libs/gtk+-3.22:3
"

S="${WORKDIR}/calendar-${PV}"

src_prepare() {
	eapply "${FILESDIR}/9c6308b2a1f3a57b1c5fffbbc2550a08fefe2cca.patch"
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
