# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Elementary OS tasks and reminders"
HOMEPAGE="https://github.com/elementary/tasks"
SRC_URI="https://github.com/elementary/tasks/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/tasks-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	$(vala_depend)
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	dev-libs/libical[glib]
	gnome-extra/evolution-data-server
	media-libs/clutter:1.0
	media-libs/clutter-gtk:1.0
	media-libs/libchamplain:0.12[gtk]
	sci-geosciences/geocode-glib:2
	app-misc/geoclue:2.0
	gui-libs/libhandy:1
	dev-libs/glib:2
	<dev-libs/granite-7:0
	x11-libs/gtk+:3
	dev-libs/libportal[gtk]
"

src_prepare() {
	eapply_user
	vala_setup
}
