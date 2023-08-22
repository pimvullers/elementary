# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="Adjust keyboard settings from Switchboard"
HOMEPAGE="https://github.com/elementary/switchboard-plug-keyboard"
SRC_URI="https://github.com/elementary/switchboard-plug-keyboard/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="
	app-i18n/ibus
	dev-libs/glib:2
	dev-libs/granite:0
	dev-libs/libxml2
	gnome-base/libgnomekbd
	pantheon-base/switchboard
	x11-libs/gtk+:3
	x11-libs/libxklavier
"

DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup
}
