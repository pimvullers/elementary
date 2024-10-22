# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Bluetooth indicator for Wingpanel"
HOMEPAGE="https://github.com/elementary/wingpanel-indicator-bluetooth"
SRC_URI="https://github.com/elementary/wingpanel-indicator-bluetooth/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:0
	pantheon-base/wingpanel
	x11-libs/gtk+:3
	x11-libs/libnotify
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}
