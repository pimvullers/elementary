# Copyright 2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Map viewer designed for elementary OS"
HOMEPAGE="https://github.com/elementary/maps"
SRC_URI="https://github.com/elementary/maps/archive/${PV}.tar.gz -> ${P}.tar.gz"

S=${WORKDIR}/maps-${PV}

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
	dev-libs/granite:7
	media-libs/libshumate:1.0
	sci-geosciences/geocode-glib:2
	app-misc/geoclue:2.0
	gui-libs/gtk:4
	gui-libs/libadwaita:1
"

src_prepare() {
	eapply_user
	vala_setup
}
