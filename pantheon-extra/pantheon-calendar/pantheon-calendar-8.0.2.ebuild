# Copyright 2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Desktop calendar app designed for elementary OS"
HOMEPAGE="https://github.com/elementary/calendar"
SRC_URI="https://github.com/elementary/calendar/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/calendar-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	app-misc/geoclue:2.0
	dev-libs/folks
	dev-libs/glib:2
	<dev-libs/granite-7:0
	dev-libs/libgee:0.8
	dev-libs/libical
	dev-libs/libportal[gtk]
	gnome-extra/evolution-data-server
	gui-libs/libhandy:1
	media-libs/clutter:1.0
	media-libs/clutter-gtk:1.0
	media-libs/libchamplain:0.12[gtk,vala]
	sci-geosciences/geocode-glib:2
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_setup
}
