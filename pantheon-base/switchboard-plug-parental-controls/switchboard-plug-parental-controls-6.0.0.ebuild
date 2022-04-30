# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="An easy parental controls plug for Switchboard"
HOMEPAGE="https://github.com/elementary/switchboard-plug-parental-controls"
SRC_URI="https://github.com/elementary/switchboard-plug-parental-controls/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64"
LICENSE="GPL-3"
SLOT="0"
IUSE="systemd"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:0
	dev-libs/malcontent
	pantheon-base/switchboard
	sys-auth/polkit
	systemd? ( sys-apps/systemd )
	sys-apps/accountsservice
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	use systemd || sed -i -e '/systemd_dep/d' meson.build data/meson.build
	vala_src_prepare
}
