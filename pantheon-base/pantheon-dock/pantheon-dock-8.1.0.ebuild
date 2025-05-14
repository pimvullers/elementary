# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="A quick app launcher and window switcher for Pantheon"
HOMEPAGE="https://github.com/elementary/dock"
SRC_URI="https://github.com/elementary/dock/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/dock-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

BDEPEND="${RDEPEND}"
RDEPEND="
	gui-libs/gtk:4[wayland]
	gui-libs/libadwaita:1
	dev-libs/libgee:0.8
	dev-libs/glib:2
	dev-libs/granite:7
"

src_prepare() {
	eapply "${FILESDIR}/find_custom.patch"
	eapply_user
	vala_setup
}
