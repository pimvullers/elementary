# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit bzr

DESCRIPTION="A Collection of Pantheon-related Plugs for Switchboard"
HOMEPAGE="https://launchpad.net/pantheon-plugs"
EBZR_REPO_URI="lp:pantheon-plugs"

LICENSE="GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="pantheon-base/switchboard"
DEPEND="dev-lang/vala:0.14"

src_prepare() {
	sed -i 's/valac/valac-0.14/' plug/compile
	sed -i 's/Color.vala//' plug/compile
	sed -i 's/Utilities.vala//' plug/compile

	PLUGS=$(ls -1 plug | grep .vala | sed 's/.vala//' | grep -v ElementarySearchBar | grep -v log | grep -v SettingsPlug)
}

src_compile() {
	cd plug
	for PLUG in ${PLUGS}; do ./compile ${PLUG};	done
}

src_install() {
	insinto /usr/share/plugs
	doins plugs/*
	exeinto /usr/share/plugs
	for PLUG in ${PLUGS}; do doexe plug/${PLUG}; done
}

