# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

DESCRIPTION="Pantheon Polkit Agent"
HOMEPAGE="https://github.com/elementary/pantheon-agent-polkit"
SRC_URI="https://github.com/elementary/pantheon-agent-polkit/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64"
IUSE="wayland"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	gui-libs/libadwaita:1
	dev-libs/glib:2
	dev-libs/granite:7
	sys-auth/polkit[introspection]
	gui-libs/gtk:4
	wayland? ( pantheon-base/pantheon-wayland )
"

src_prepare() {
	use wayland || eapply -R "${FILESDIR}/9c63b8414aaad026186b76ee73aaad92dd2f5d2b.patch"
	eapply_user
	vala_setup
}
