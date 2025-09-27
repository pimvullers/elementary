# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Date & Time indicator for Wingpanel"
HOMEPAGE="https://github.com/elementary/panel-datetime"
SRC_URI="https://github.com/elementary/panel-datetime/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/glib:2
	<dev-libs/granite-7:0
	dev-libs/libical
	gnome-extra/evolution-data-server[vala]
	net-libs/libsoup:2.4
	pantheon-base/wingpanel
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

S="${WORKDIR}/panel-datetime-${PV}"

src_prepare() {
	eapply_user
	vala_setup
}
