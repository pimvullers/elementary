# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Access frequently used settings and system actions"
HOMEPAGE="https://github.com/elementary/quick-settings"
SRC_URI="https://github.com/elementary/quick-settings/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:0
	gui-libs/libhandy:1
	pantheon-base/wingpanel
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	eapply "${FILESDIR}/${P}_drop_packagekit.patch"
	vala_setup
}
