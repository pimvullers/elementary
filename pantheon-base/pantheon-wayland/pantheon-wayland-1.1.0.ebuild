# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

DESCRIPTION="Wayland integration library to the Pantheon Desktop"
HOMEPAGE="https://github.com/elementary/pantheon-wayland"
SRC_URI="https://github.com/elementary/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	dev-libs/glib:2
	dev-libs/wayland
	gui-libs/gtk:4[wayland]
"
RDEPEND="${DEPEND}"
BDEPEND="
	$(vala_depend)
	dev-util/wayland-scanner
"

src_prepare() {
	eapply_user
	vala_setup
}
