# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.20

inherit gnome2 meson vala

DESCRIPTION="Configure the Pantheon desktop environment using Switchboard"
HOMEPAGE="https://github.com/elementary/switchboard-plug-pantheon-shell"
SRC_URI="https://github.com/elementary/switchboard-plug-pantheon-shell/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="2"
KEYWORDS="amd64"

RDEPEND="
	!pantheon-base/switchboard-plug-pantheon-shell:0
	dev-libs/glib:2
	dev-libs/granite:0
	media-libs/gexiv2[vala]
	gnome-base/gnome-desktop:=
	pantheon-base/switchboard:2
	pantheon-extra/contractor
	>=x11-libs/gtk+-3.22:3
	>=x11-misc/plank-0.10.9
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}
