# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.20

inherit meson vala

DESCRIPTION="Switchboard plug for Online Accounts management"
HOMEPAGE="https://github.com/elementary/switchboard-plug-onlineaccounts"
SRC_URI="https://github.com/elementary/switchboard-plug-onlineaccounts/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:0
	pantheon-base/switchboard
	gnome-extra/evolution-data-server
	x11-libs/gtk+:3
	gui-libs/libhandy"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

src_prepare() {
	eapply_user
	vala_setup
}
