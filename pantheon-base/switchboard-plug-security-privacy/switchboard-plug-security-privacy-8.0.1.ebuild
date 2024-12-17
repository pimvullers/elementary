# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Configure various aspects of the security of the system."
HOMEPAGE="https://github.com/elementary/switchboard-plug-security-privacy"
SRC_URI="https://github.com/elementary/switchboard-plug-security-privacy/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:7
	pantheon-base/switchboard:3
	sys-auth/polkit
	gui-libs/gtk:4
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	eapply "${FILESDIR}/${PN}-8.0.0_drop_zeitgeist.patch"
	vala_setup
}
