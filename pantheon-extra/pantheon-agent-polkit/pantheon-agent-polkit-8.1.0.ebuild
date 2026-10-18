# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Pantheon Polkit Agent"
HOMEPAGE="https://github.com/elementary/pantheon-agent-polkit"
SRC_URI="https://github.com/elementary/pantheon-agent-polkit/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE="wayland"

RDEPEND="
	gui-libs/libadwaita:1
	dev-libs/glib:2
	dev-libs/granite:7
	sys-auth/polkit[introspection]
	gui-libs/gtk:4
	wayland? ( >=pantheon-base/pantheon-wayland-1.1.0 )
"
DEPEND="${RDEPEND}"
BDEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	use wayland || eapply "${FILESDIR}/drop-wayland.patch"
	eapply_user
	vala_setup
}
