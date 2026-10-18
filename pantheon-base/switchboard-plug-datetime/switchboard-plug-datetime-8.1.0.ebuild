# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

DESCRIPTION="Configure the date & time of the user"
HOMEPAGE="https://github.com/elementary/settings-datetime"
SRC_URI="https://github.com/elementary/settings-datetime/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/settings-datetime-${PV}"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="amd64"

RDEPEND="
	dev-libs/glib:2
	dev-libs/granite:7
	pantheon-base/switchboard:3
	gui-libs/gtk:4
	gui-libs/libadwaita:1
"
DEPEND="${RDEPEND}"
BDEPEND="
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}
