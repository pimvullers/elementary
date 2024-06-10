# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Captive Network Assistant"
HOMEPAGE="https://github.com/elementary/capnet-assist"
SRC_URI="https://github.com/elementary/capnet-assist/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:7
	app-crypt/gcr:4
	net-libs/webkit-gtk:6
	gui-libs/gtk:4"
DEPEND="${RDEPEND}
	$(vala_depend)"

S="${WORKDIR}/capnet-assist-${PV}"

src_prepare() {
	eapply_user
	vala_setup
}
