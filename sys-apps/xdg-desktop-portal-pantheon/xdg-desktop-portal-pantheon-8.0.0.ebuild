# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

DESCRIPTION="Pantheon XDG Desktop Portals"
HOMEPAGE="https://github.com/elementary/portals"
SRC_URI="https://github.com/elementary/portals/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/portals-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="systemd wayland"

DEPEND="
	dev-libs/glib:2
	dev-libs/granite:7
	gui-libs/gtk:4
	x11-libs/libX11"
RDEPEND="${DEPEND}
	systemd? ( sys-apps/systemd )
	wayland? ( pantheon-base/pantheon-wayland )
"

src_prepare() {
	eapply_user
	use wayland || eapply -R "${FILESDIR}/1a825f6dcba9a0c42f369a933eaa38c4dbb8a0ec.patch"
	use systemd || eapply "${FILESDIR}/${PN}-7.0.0.patch"
	vala_setup
}
