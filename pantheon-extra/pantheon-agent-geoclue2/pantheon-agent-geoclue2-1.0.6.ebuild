# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Location services agent"
HOMEPAGE="https://github.com/elementary/pantheon-agent-geoclue2"
SRC_URI="https://github.com/elementary/pantheon-agent-geoclue2/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	app-misc/geoclue
	dev-libs/glib:2
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_setup
}
