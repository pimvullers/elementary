# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Bluetooth indicator for Wingpanel"
HOMEPAGE="https://github.com/elementary/panel-bluetooth"
SRC_URI="https://github.com/elementary/panel-bluetooth/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/glib:2
	<dev-libs/granite-7:0
	pantheon-base/wingpanel
	x11-libs/gtk+:3
	x11-libs/libnotify
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"
S="${WORKDIR}/panel-bluetooth-${PV}"

src_prepare() {
	eapply_user
	vala_setup
}
