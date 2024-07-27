# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="Configure all available networks"
HOMEPAGE="https://github.com/elementary/switchboard-plug-network"
SRC_URI="https://github.com/elementary/switchboard-plug-network/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="2"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	!pantheon-base/switchboard-plug-network:0
	dev-libs/glib:2
	dev-libs/granite:0
	gnome-extra/nm-applet
	>=net-misc/networkmanager-1.8[vala]
	pantheon-base/switchboard:2
	sys-auth/polkit
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}
