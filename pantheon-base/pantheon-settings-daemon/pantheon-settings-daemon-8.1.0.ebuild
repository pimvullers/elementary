# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd gnome2 meson vala

DESCRIPTION="Pantheon settings daemon"
HOMEPAGE="https://github.com/elementary/settings-daemon"
SRC_URI="https://github.com/elementary/settings-daemon/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="systemd"

DEPEND=""
RDEPEND="${DEPEND}
	dev-libs/granite:0
	dev-libs/glib:2
	app-misc/geoclue:2.0
	sys-apps/accountsservice
	sys-apps/fwupd
	systemd? ( sys-apps/systemd )
"

S="${WORKDIR}/settings-daemon-${PV}"

src_prepare() {
	eapply "${FILESDIR}/${P}_drop_packagekit.patch"
	eapply_user
	vala_setup
}

src_configure() {
	local emesonargs=(
		-Dubuntu_drivers=false
		-Dsystemduserunitdir=$(usex systemd $(systemd_get_userunitdir) no)
		-Dsystemdsystemunitdir=$(usex systemd $(systemd_get_systemunitdir) no)
	)
	meson_src_configure
}
