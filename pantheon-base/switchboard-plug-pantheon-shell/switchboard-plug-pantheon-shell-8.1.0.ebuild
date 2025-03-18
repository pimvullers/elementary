# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.20

inherit gnome2 meson vala

DESCRIPTION="Configure the Pantheon desktop environment using Switchboard"
HOMEPAGE="https://github.com/elementary/switchboard-plug-pantheon-shell"
SRC_URI="https://github.com/elementary/switchboard-plug-pantheon-shell/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:7
	media-libs/gexiv2[vala]
	pantheon-base/switchboard:3
	gui-libs/gtk:4
	gui-libs/libadwaita:1
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

S="${WORKDIR}/settings-desktop-${PV}"

src_prepare() {
	eapply_user
	vala_setup
}
