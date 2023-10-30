# Copyright 2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="A system settings panel for the Pantheon DE"
HOMEPAGE="https://github.com/pantheon-tweaks/pantheon-tweaks"
SRC_URI="https://github.com/pantheon-tweaks/pantheon-tweaks/archive/refs/tags//${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite:0
	dev-libs/libgee:0.8
	pantheon-base/switchboard
	x11-libs/gtk+:3
"

src_prepare() {
	eapply_user
	vala_setup
}
