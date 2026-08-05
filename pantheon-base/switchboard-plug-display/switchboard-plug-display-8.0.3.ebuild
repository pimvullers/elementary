# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

DESCRIPTION="Settings plug to show displays information"
HOMEPAGE="https://github.com/elementary/settings-display"
SRC_URI="https://github.com/elementary/settings-display/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/settings-display-${PV}"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="amd64"

RDEPEND="
	!pantheon-base/switchboard-plug-display:0
	dev-libs/glib:2
	dev-libs/granite:7
	pantheon-base/switchboard:3
	gui-libs/gtk:4
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}
