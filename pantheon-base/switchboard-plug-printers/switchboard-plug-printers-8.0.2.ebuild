# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.34

inherit meson vala

DESCRIPTION="A printers plug for Switchboard"
HOMEPAGE="https://github.com/elementary/settings-printers"
SRC_URI="https://github.com/elementary/settings-printers/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:7
	net-print/cups
	pantheon-base/switchboard:3
	gui-libs/gtk:4
	gui-libs/libadwaita:1
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"
S="${WORKDIR}/settings-printers-${PV}"

src_prepare() {
	eapply_user
	vala_setup
}
